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
