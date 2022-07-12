# load tidyverse
suppressPackageStartupMessages(library(tidyverse))

# set ggplot theme
theme_set(theme_bw())

cat('\n######################')
cat('\n# BOX TOY: INFERENCE #')
cat('\n######################\n\n')

# set number of boxes as user input
suppressWarnings(n_boxes <- as.numeric(readline(prompt='Type the number of boxes (>= 3): ')))
while (is.na(n_boxes) | n_boxes != as.integer(n_boxes) | n_boxes < 3) {
  cat('Invalid input!\n\n')
  suppressWarnings(n_boxes <- as.numeric(readline(prompt='Type the number of boxes (>= 3): ')))
}
n_boxes <- as.integer(n_boxes)

# initialize tibble 'box_toy'
extraction <- 0L                      # number of extractions performed        
colour     <- '-'                     # colour of extracted ball as "B" or "W" ("black" or "white")
priors     <- rep(1/n_boxes, n_boxes) # prior probabilities
prob_black <- 0.5                     # probability of extracting black ball on next draw
prob_white <- 1-prob_black            # probability of extracting white ball on next draw

box_toy <- tibble(
                Extraction = rep(extraction, n_boxes),
                Colour     = rep(colour, n_boxes),
                box_label  = str_glue('P(H_{seq(0, n_boxes-1)})'),
                box_prob   = priors,
                'P(E_b)'   = rep(prob_black, n_boxes),
                'P(E_w)'   = rep(prob_white, n_boxes))

# print tibble 'box_toy'
cat('\n')
print(box_toy %>% pivot_wider(names_from=box_label, values_from=box_prob), width=Inf, n=Inf)
cat('\n')

# load colour of 1st extracted ball as user input
colour <- toupper(readline(prompt=str_glue('[Extraction #{extraction+1}] Type the colour of the extracted ball as "B" or "W" ("black" or "white"), otherwise, type "Q" to quit this program: ')))
while (!(colour %in% c('B', 'W', 'Q'))) {
  cat('Invalid input!\n\n')
  colour <- toupper(readline(prompt=str_glue('[Extraction #{extraction+1}] Type the colour of the extracted ball as "B" or "W" ("black" or "white"), otherwise, type "Q" to quit this program: ')))
}

while (colour != 'Q') {
  
  extraction <- extraction+1L
  
  if (colour == 'B') {
    likelihoods <- 1-seq(0, n_boxes-1)/(n_boxes-1)            # likelihoods
    posteriors  <- likelihoods*priors/sum(likelihoods*priors) # posterior probabilities
    prob_black  <- sum(likelihoods*posteriors)
    prob_white  <- 1-prob_black
  } else {
    likelihoods <- seq(0, n_boxes-1)/(n_boxes-1)              # likelihoods
    posteriors  <- likelihoods*priors/sum(likelihoods*priors) # posterior probabilities
    prob_white  <- sum(likelihoods*posteriors)
    prob_black  <- 1-prob_white
  }
  
  # update tibble 'box_toy'
  box_toy <- box_toy %>% add_row(
                                Extraction = rep(extraction, n_boxes),
                                Colour     = rep(colour, n_boxes),
                                box_label  = str_glue('P(H_{seq(0, n_boxes-1)})'),
                                box_prob   = posteriors,
                                'P(E_b)'   = rep(prob_black, n_boxes),
                                'P(E_w)'   = rep(prob_white, n_boxes))
  
  # print tibble 'box_toy'
  cat('\n')
  print(box_toy %>% pivot_wider(names_from=box_label, values_from=box_prob), width=Inf, n=Inf)
  cat('\n')

  # save tibble 'box_toy' to .csv file
  write_csv(box_toy, str_glue('{n_boxes}_box_toy_inference.csv'))

  # plot probabilities
  p <- ggplot(data=box_toy, aes(x=Extraction, y=box_prob)) +
        geom_line(alpha=.5, colour='red', size=.5) +
        geom_point(colour='black', size=1) +
        scale_x_continuous(breaks=seq(0, extraction, by=ceiling(extraction/10))) +
        scale_y_continuous(n.breaks=6, limits=c(0, 1)) +
        xlab('Extraction #') +
        ylab('Probability') +
        facet_wrap(vars(box_label), ncol=3, labeller=label_bquote(P(H[.(str_sub(box_label, start=5, end=-2))]))) +
        theme(strip.background = element_rect(fill="aliceblue"),
              strip.text       = element_text(size=14, margin=margin(t=.5, b=.5)))
  print(p)
  
  # save plot to .pdf file
  ggsave(str_glue('{n_boxes}_box_toy_inference.pdf'), width=12.5, height=3.5*ceiling(n_boxes/3))
  
  # update prior probabilities for next draw
  priors <- posteriors
  
  # load colour of next extracted ball as user input
  colour <- toupper(readline(prompt=str_glue('[Extraction #{extraction+1}] Type the colour of the extracted ball as "B" or "W" ("black" or "white"), otherwise, type "Q" to quit this program: ')))
  while (!(colour %in% c('B', 'W', 'Q'))) {
    cat('Invalid input!\n\n')
    colour <- toupper(readline(prompt=str_glue('[Extraction #{extraction+1}] Type the colour of the extracted ball as "B" or "W" ("black" or "white"), otherwise, type "Q" to quit this program: ')))
  }
  
}