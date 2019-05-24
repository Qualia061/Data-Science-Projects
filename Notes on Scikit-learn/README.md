## Some Notes on Python Scikit-learn
Examples using the scikit-learn machine learning library (will be updated frequently)


## Data Preprocessing
  - Identifying Missing Values:
  
	df.isnull.sum()
	
  - Remove Missing Data:
  
	df.dropna(axis=0)
	
  - Interpolation:
    ```python
	from sklearn.impute import SimpleImputer
	import numpy as np
	imr = SimpleImputer(missing_values=np.nan, strategy='constant', fill_value=42)
	imr = SimpleImputer(missing_values=np.nan, strategy='mean')
	print(df.values)
	imr = imr.fit(df.values)
	imputed_data = imr.transform(df.values)
	```
  - Encoding Class Labels:
  
    Method 1:
    ```python
	from sklearn.preprocessing import LabelEncoder
	class_le = LabelEncoder()
	y = class_le.fit_transform(df2['classlabel'].values)
	y
	class_le.inverse_transform(y)
	```
    Method 2:
    ```python
	from sklearn.preprocessing import OneHotEncoder
	from sklearn.compose import ColumnTransformer
	ohct = ColumnTransformer([('color', OneHotEncoder(categories='auto'), [0]), 
				  ('size', 'passthrough',[1]), 
				  ('price', 'passthrough', [2])])
	ohct.fit_transform(X)	
	pd.get_dummies(df2[['price', 'color', 'size']])
	```
  - Training-Testing:
    ```python
	from sklearn.model_selection import train_test_split
	X, y = df_wine.iloc[:, 1:].values, df_wine.iloc[:, 0].values
	X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=0, stratify=y)
	print(X_train.shape)
	print(X_test.shape)
	print(y_train.shape)
	print(y_test.shape)
	```
  - Feature Scaling:
    ```python
 	#Normalization
	from sklearn.preprocessing import MinMaxScaler
	mms = MinMaxScaler()
	X_train_norm = mms.fit_transform(X_train)
	X_test_norm = mms.transform(X_test)
	
	#Standardization
	from sklearn.preprocessing import StandardScaler
	stdsc = StandardScaler()
	X_train_std = stdsc.fit_transform(X_train)
	X_test_std = stdsc.fit_transform(X_test)
	```
  - Regularization
  
  - Sequential Backward Selection
  
## Dimensionality Reduction
  - PCA & LDA:
    ```python
	from sklearn.decomposition import PCA
	pca = PCA(n_components=2)
	X_train_pca = pca.fit_transform(X_train_std)
	X_test_pca = pca.transform(X_test_std)
	
	from sklearn.discriminant_analysis import LinearDiscriminantAnalysis as LDA
	lda = LDA(n_components=2)
	X_train_lda = lda.fit_transform(X_train_std, y_train)
	X_test_lda = lda.transform(X_test_std)
	```

## Evaluation & Tuning
  - pipeline:
    ```python
	from sklearn.preprocessing import StandardScaler
	from sklearn.decomposition import PCA
	from sklearn.linear_model import LogisticRegression
	from sklearn.pipeline import make_pipeline
	pipe_lr = make_pipeline(StandardScaler(), PCA(n_components=2), LogisticRegression(random_state=1, solver='lbfgs'))
	pipe_lr.fit(X_train, y_train)
	y_pred = pipe_lr.predict(X_test)
	print('Test Accuracy: %.3f' % pipe_lr.score(X_test, y_test))
	```
  - K-Fold Cross-Validation:
    ```python
	from sklearn.model_selection import cross_val_score
	scores = cross_val_score(estimator=pipe_lr, X=X_train, y=y_train, cv=10, n_jobs=1)
	print('CV accuracy scores: %s' % scores)
	print('CV accuracy: %.3f +/- %.3f' % (np.mean(scores), np.std(scores)))
	```
  - Learning Curve
  
  - Validation Curve
  
  - Tuning Hyperparameters:
    ```python
	from sklearn.model_selection import GridSearchCV
	from sklearn.svm import SVC
	pipe_svc = make_pipeline(StandardScaler(), SVC(random_state=1))
	param_range = [0.0001, 0.001, 0.01, 0.1, 1.0, 10.0, 100.0, 1000.0]
	param_grid = [{'svc__C': param_range, 'svc__kernel': ['linear']}, 
		      {'svc__C': param_range, 'svc__gamma': param_range, 'svc__kernel': ['rbf']}]
	gs = GridSearchCV(estimator=pipe_svc, param_grid=param_grid, scoring='accuracy', cv=10, n_jobs=1)
	gs = gs.fit(X_train, y_train)
	print(gs.best_score_)
	print(gs.best_params_)
	
	clf = gs.best_estimator_
	clf.fit(X_train, y_train)
	print('Test accuracy: %.3f' % clf.score(X_test, y_test))
	
	gs = GridSearchCV(estimator=pipe_svc, param_grid=param_grid, scoring='accuracy', cv=2)
	scores = cross_val_score(gs, X_train, y_train, scoring='accuracy', cv=5)
	print('CV accuracy: %.3f +/- %.3f' % (np.mean(scores), np.std(scores)))
	```
  - ROC & AUC Graph
  - Resampling:
    ```python
	from sklearn.utils import resample
	print('Number of class 1 samples before:', X_imb[y_imb == 1].shape[0])
	X_upsampled, y_upsampled = resample(X_imb[y_imb == 1], y_imb[y_imb == 1], replace=True,
					    n_samples=X_imb[y_imb == 0].shape[0], random_state=123)
	print('Number of class 1 samples after:', X_upsampled.shape[0])
	```
