function [score] = scoreFN(original, altered) 
    %This method is untested and probably not correct.
    score = 0;

    for height = 1:size(image, 1)
        for width = 1:size(image,2)
            temp = 0;
            for depth = 1:size(image,3)
                temp = temp + sqrt((original(height,width,depth) - altered(height,width,depth)).^2 );
            end
            score = score + sqrt(temp);
        end
    end
    
    fprintf('%d\n', score);
end