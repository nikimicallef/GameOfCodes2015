function [outCJP] = toCJP(image, txtName)
    image = imread(image);
    
    fid = fopen(txtName, 'wt' );
    
    fprintf(fid, '%d \n', size(image, 2));
    fprintf(fid, '%d \n', size(image, 1));
    
    %image = double(image)/255;
    
    for height = 1:size(image, 1)
        for width = 1:size(image,2)
            red = image(height,width,1);
            if size(image, 3) > 1
                green = image(height,width,2);
                blue = image(height,width,3);
            end
            rgbMatrix = [red green blue];
            rgb = round(rgbMatrix);
            hex(:,1:6) = reshape(sprintf('%02X',rgb.'),6,[]).'; 
            fprintf(fid, '%s', hex);
            if mod(width,size(image,2)) ~= 0
                fprintf(fid, ' ');
            end
        end
        fprintf(fid, '\n');
    end
    
    outCJP = fid;
end