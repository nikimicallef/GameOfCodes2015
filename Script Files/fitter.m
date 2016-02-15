function image_listing = fitter(png_image,png_composition_images,n)
    img = double(png_image)/255;
    
    for i = 1 : size(png_composition_images,2)
        kernels{1,i} = double(png_composition_images{1,i})/255;
    end
    
    image_listing = zeros(n,7);
    image_listing_counter = 1;
    [img1,coordinates] = splitimage(img,n);

    diff=10000000;
    currentX=1;
    currentY=1;

    for i = 1:size(img1,1)
        for j = 1:size(img1,2)

            % Empty Picture
            if(size(img1{i,j},1) == 0)
                currentY=currentY+1;
                continue
            end

            % Kernel Size is Smaller to Image Partition
            if(size(kernels{1,1},1)<size(img1{i,j},1) || size(kernels{1,1},2)<size(img1{i,j},2))
                currentY=currentY+1;   
                continue;
            end

            % Find bestFitInKernel for 1st Kernel
            [currentBestFitInKernel,currentDiff, xCoord, yCoord] = bestFitInKernel(kernels{1,1},img1{i,j});
            if(diff>currentDiff)
                bestFitter = currentBestFitInKernel;
                diff = currentDiff;
                image_id = 0;
                x_Coordinate = xCoord - 1;
                y_Coordinate = yCoord - 1;
            end

            for k = 2:size(kernels,2)

                 % Kernel Size is Smaller to Image Partition
                if(size(kernels{1,k},1)<size(img1{i,j},1) || size(kernels{1,k},2)<size(img1{i,j},2))
                    continue;
                end

                [currentBestFitInKernel,currentDiff, xCoord, yCoord] = bestFitInKernel(kernels{1,k},img1{i,j});

                if(diff>currentDiff)
                    bestFitter = currentBestFitInKernel;
                    diff = currentDiff;
                    image_id = k - 1;
                    x_Coordinate = xCoord - 1;
                    y_Coordinate = yCoord - 1;
                end
            end

            output(currentX,currentY,:)= {bestFitter};
            currentY=currentY+1;
            diff = 10000000;
            image_listing(image_listing_counter,:) = [image_id x_Coordinate y_Coordinate size(bestFitter,2) size(bestFitter,1) coordinates{i,j}(1,1) coordinates{i,j}(1,2)];
            image_listing_counter = image_listing_counter + 1;
        end
        currentY=1;
        currentX= currentX+1;

    end

    square = ceil(sqrt(n));
    remaining = (square*square)-n;

    output2 = linearize(output(:,:,:),remaining);
    figure; imshow(reShape(output2(:,:,:)));
end