function [reSizedKernel,tempMin, xCoord, yCoord] = bestFitInKernel(kernel,imInSegment)
   
    imInSegmentSizeX = size(imInSegment,1);
    imInSegmentSizeY = size(imInSegment,2);
    
    X_kernel = size(kernel,1);
    Y_kernel = size(kernel,2);
        
    % Loop Every Quarter
    X_KernelRatio = imInSegmentSizeX/4;
    Y_KernelRatio = imInSegmentSizeY/4;
    
    tempMin=1000000000;
    xCoord = 1;
    yCoord = 1;
    
    % iterate per quarter of the image
    % find the temporary location in terms of x,y 
    % find error with image
    % return minimum 
    for i= round(1:X_KernelRatio:X_kernel)
        for j = round(1:Y_KernelRatio:Y_kernel)

            if(i+imInSegmentSizeX-1 > X_kernel || j+imInSegmentSizeY-1 > Y_kernel) 
                continue;
            else
                currentKernel = kernel(i:i+imInSegmentSizeX-1,j:j+imInSegmentSizeY-1,:);

                difference = sum(sum(sum(abs(imInSegment - currentKernel))));

                if(difference < tempMin)
                    reSizedKernel = currentKernel;
                    tempMin = difference;
                    xCoord = i;
                    yCoord = j;
                end
            end
        end
    end
end

