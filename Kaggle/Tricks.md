# **_Preprocessing:outliers_**


```python
UPPERBOUND, LOWERBOUND = np.percentile(x,[1,99])
y = np.clip(x, UPPERBOUND, LOWERBOUND)
pd,Series(y).hist(bins=30)
```
