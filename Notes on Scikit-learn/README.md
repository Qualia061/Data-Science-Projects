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
