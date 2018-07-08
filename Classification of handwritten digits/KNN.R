
predict_knn <- function(test_data, train_data, k, methodd){
  dff=c()
  points_train_binded=as.matrix(rbind(test_data[,-1],train_data[,-1])) # rbind two matrices
  distance=as.matrix(dist(points_train_binded, method = methodd)) #distance between each pair of rows
  
  for(i in c(1:nrow(test_data))){   #looping over each record of test data
    dist =c()          #dist & char empty  vector
    char = c()
    
    #adding distance b/w test data point and train data to dist vector
    dist <- c(distance[i,(nrow(test_data)+1):ncol(distance)])
    
    
    #adding class variable of training data in char
    char <- c(as.integer(train_data[,1]))
    
    
    df <- data.frame(char, dist) #df dataframe created with char & dist columns
    
    df <- df[order(df$dist),]       #sorting df dataframe to gettop K neighbors
    df <- df[1:k,]               #df dataframe with top K neighbors
    dff=c(dff,tail(names(sort(table(df$char))),1)) # save the most frequenct label
    
  }
  return(dff) #return predictions
}


cv_error_knn <- function(train_data, fold, k , methodd){
  n <- dim(train_data)[1] # number of rows
  Sam <- sample(1:n, n, replace = F) # randomize
  error <- c() #initialization
  train <- train_data[,-1] #without response column
  label <- train_data[,1] # the response column
  delta <- floor(n/fold)
  for (i in 1:fold){  # selection
    index <- delta * (i-1) + 1
    if(i < fold){
      s <- index:(index + delta - 1)
    }else{
      s <- index:n
    }
    l <- Sam[s]
    m_test <- train[l, ]
    m_train <- train[-l, ]
    y_test <- label[l]
    y_train <- label[-l]
    model <- as.numeric(predict_knn(cbind(y_test, m_test), cbind(y_train, m_train), k, methodd)) # call knn function
    error[i] <- length(which( (model == y_test) == FALSE)) / length(l) # calculate the error rate
  }
  mean(error)
}
start_time <- Sys.time()
cv_error_knn(train_data = train, fold = 10, k = 3, methodd = "euclidean")
end_time <- Sys.time()
end_time - start_time
