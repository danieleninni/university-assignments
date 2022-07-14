def grid_search(X_train=None, y_train=None,
                X_test=None,  y_test=None, 
                
                estimator=None, param_grid=None, scoring=None,
                n_jobs=None,    cv=None,         verbose=10,

                results_save=True,        results_fname=None,         # .csv
                best_estimator_save=True, best_estimator_fname=None): # .joblib

        from sklearn.model_selection import GridSearchCV
        from datetime import datetime
        import pandas as pd
        from joblib import dump

        print('+--------------------------------------+')
        print('| sklearn.model_selection.GridSearchCV |')
        print('+--------------------------------------+')

        # set the grid search
        clf = GridSearchCV(
                        estimator=estimator,
                        param_grid=param_grid,
                        scoring=scoring,
                        n_jobs=n_jobs, 
                        cv=cv,
                        verbose=verbose
                        )

        # fit the estimator
        print('Fitting the estimator...')
        clf.fit(X_train, y_train)
        print('Done!')

        # save the results of the grid search to .csv file
        if results_save is True:
            if results_fname is None:
                results_fname = f"cv_results_{datetime.now().strftime('%Y-%m-%d_%H.%M.%S')}.csv"
            results = pd.DataFrame(clf.cv_results_)
            results.to_csv(results_fname, index=False)
            print(f'The results of the grid search have been saved to "{results_fname}".')

        # save the best model to .joblib file (https://scikit-learn.org/stable/modules/model_persistence.html)
        if best_estimator_save is True:
            if best_estimator_fname is None:
                best_estimator_fname = f"best_estimator_{datetime.now().strftime('%Y-%m-%d_%H.%M.%S')}.joblib"
            dump(clf.best_estimator_, best_estimator_fname)
            print(f'The best model has been saved to "{best_estimator_fname}".')

        # print the results of the grid search
        print('\nBest estimator:\n', clf.best_estimator_)
        print('Best score:', clf.best_score_)
        print('Best parameters:', clf.best_params_)
 
        # print the score on the training set
        train_score = clf.score(X_train, y_train)
        print('\nScore on training set:', train_score)

        # print the score on the test set
        if ((X_test is not None) and (y_test is not None)):
            test_score = clf.score(X_test, y_test)
            print('Score on test set:', test_score)

        return results, clf.best_estimator_