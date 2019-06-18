## Preprocessing:outliers

```python
UPPERBOUND, LOWERBOUND = np.percentile(x,[1,99])
y = np.clip(x, UPPERBOUND, LOWERBOUND)
pd,Series(y).hist(bins=30)
```

# Feature Generation

## Numeric Features

1. Fractional part

## Date and Time

1. Periodicity

2. Time Since

3. Difference between dates


## Coordinates

1. Interesting places from train/test data or additional data

2. Centers of clusters

3. Aggregated statistics

# Fillna approaches

1. Replace NaN with True/False

2. In general, avoid filling NaN before feature generation