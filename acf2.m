function res = acf2 (series)

    [n,m] = size(series);
    res = zeros(n,m);
   
    for i=1:m
        res(i) = acf2_k(series,i);
        if ( isnan(res(i)) )
            res(i) = 0;
        end
    end
    
end

function inter = acf2_k(series,k)

    [n,m] = size(series);
    if ( k >= m )
        inter = 0;
        return
    end
    tempSeries = zeros(n,m);
    uSeries = mean(series,2);

	tempSeries(1,k+1:end) = series(1,1:end-k);
    utempSeries = mean(tempSeries,2);
            
    res1 = (series - uSeries);
    res2 = (tempSeries - utempSeries);
    
    res = sum(res1.*res2/m,'all');
    
    inter = res/(std(series)*std(tempSeries));
   
end