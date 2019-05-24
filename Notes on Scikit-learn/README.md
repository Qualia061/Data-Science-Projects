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