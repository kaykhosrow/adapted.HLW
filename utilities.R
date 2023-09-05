
shiftYear <- function(original.start, shift) {
  new.start = c(0, 0)
  
  if (shift > 0) {
    new.start[1] = original.start[1] + shift
    new.start[2] = 1
  } else {
    new.start[1] = original.start[1] - abs(shift)
    new.start[2] = 1
  }
  
  return(new.start)
}


shiftMonth <- function(original.start,shift){

    if (shift > 0) {
        new.start = c(0,0)
        sum = original.start[2] + shift
    
        if (sum <= 12) {
            new.start[1] = original.start[1]
        }
        else {
            new.start[1] = original.start[1] + ceiling(sum/12) - 1
        }

        if (sum %% 12 > 0) {
            new.start[2] = sum %% 12
        }
        else {
            new.start[2] = sum %% 12 + 12
        }
    }

    else {
        new.start = c(0,0)
        diff = original.start[2] - abs(shift)
    
        if (diff > 0) {
            new.start[1] = original.start[1]
        }
        else {
            new.start[1] = original.start[1] - (1 + floor(abs(diff)/12))
        }

        if (diff %% 12 > 0) {
            new.start[2] = diff %% 12
        }
        else {
            new.start[2] = diff %% 12 + 12
        }
    }
        
return(new.start)}


gradient <- function(f, x, delta = x * 0 + 1.0e-5) {
    g <- x * 0
    for (i in 1:length(x)) {
        x1 <- x
        x1[i] <- x1[i] + delta[i]
        f1 <- f(x1)
        x2 <- x
        x2[i] <- x2[i] - delta[i]
        f2 <- f(x2)
        g[i] <- (f1 - f2) / delta[i] / 2
    }
    return(g)
}
