function [output] = linearize(output, noOfElements)
    for i = 1 : size(output,1)
        for j = 1 : size(output,2)
   
            if(size(output{i,j,:},1) == 0 && size(output{i,j,:},2) == 0)
                if(i == 1)
                    output{i,j,:} = output{i,j-1,:}((size(output{i,j-1,:},1)/2)+1:size(output{i,j-1,:},1),:,:);
                    output{i,j-1,:} = output{i,j-1,:}(1:size(output{i,j-1,:},1)/2,:,:);
                    noOfElements = noOfElements - 1;
                elseif(j == 1)
                    output{i,j,:} = output{i-1,j,:}((size(output{i-1,j,:},1)/2)+1:size(output{i-1,j,:},1),:,:);
                    output{i-1,j,:} = output{i-1,j,:}(1:size(output{i-1,j,:},1)/2,:,:);
                    noOfElements = noOfElements - 1;
                elseif(size(output{i-1,j,:},1) > size(output{i,j-1,:},1)) 
                    output{i,j,:} = output{i-1,j,:}((size(output{i-1,j,:},1)/2)+1:size(output{i-1,j,:},1),:,:);
                    output{i-1,j,:} = output{i-1,j,:}(1:size(output{i-1,j,:},1)/2,:,:);
                    noOfElements = noOfElements - 1;
                elseif(size(output{i-1,j,:},2) > size(output{i,j-1,:},2))
                    output{i,j,:} = output{i-1,j,:}(:,(size(output{i-1,j,:},2)/2)+1:size(output{i-1,j,:},2),:);
                    output{i-1,j,:} = output{i-1,j,:}(:,1:size(output{i-1,j,:},2)/2,:);
                    noOfElements = noOfElements - 1;
                elseif(size(output{i-1,j,:},1) < size(output{i,j-1,:},1))
                    output{i,j,:} = output{i,j-1,:}((size(output{i,j-1,:},1)/2)+1:size(output{i,j-1,:},1),:,:);
                    output{i,j-1,:} = output{i,j-1,:}(1:size(output{i,j-1,:},1)/2,:,:);
                    noOfElements = noOfElements - 1;
                elseif(size(output{i-1,j,:},2) < size(output{i,j-1,:},2))
                    output{i,j,:} = output{i,j-1,:}(:,(size(output{i,j-1,:},2)/2)+1:size(output{i,j-1,:},2),:);
                    output{i,j-1,:} = output{i,j-1,:}(:,1:size(output{i,j-1,:},2)/2,:);
                    noOfElements = noOfElements - 1;    
                elseif(size(output{i-1,j,:},1) == size(output{i,j-1,:},1) && size(output{i-1,j,:},2) == size(output{i,j-1,:},2))
                    output{i,j,:} = output{i-1,j,:}((size(output{i-1,j,:},1)/2)+1:size(output{i-1,j,:},1),:,:);
                    output{i-1,j,:} = output{i-1,j,:}(1:size(output{i-1,j,:},1)/2,:,:);
                    noOfElements = noOfElements - 1;
                else
                    continue;
                end
            end
                
            if(noOfElements <= 0)
                break;
            end
        end
        if(noOfElements <= 0)
            break;
        end
    end
            