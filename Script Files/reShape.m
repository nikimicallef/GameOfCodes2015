function [imOut] = reShape(output)
    xSizeOutput = size(output,1);
    ySizeOutput = size(output,2);
    
    imOut= [];
    temp = [];
    
    for i= 1:xSizeOutput    
        for j = 1:ySizeOutput
            temp = [temp output{i,j,:}];
        end
        imOut = [imOut; temp ];
        temp = [];
    end
    
end

