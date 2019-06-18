## Preprocessing:outliers

```python
UPPERBOUND, LOWERBOUND = np.percentile(x,[1,99])
y = np.clip(x, UPPERBOUND, LOWERBOUND)
pd,Series(y).hist(bins=30)
```

## Date and Time

1. Periodicity

2. Time Since

3. Difference between dates