function [out, coordinates] = splitimage(im,n)
    [row, col, depth]=size(im);
    square = ceil(sqrt(n));
    remaining = (square*square)-n;

    tempRow = square;
    tempCol = square;

    aa=1:floor(row/square):floor(row/square)*square;
    bb=1:floor(col/square):floor(col/square)*square;
    
    coordinates = [];
    temp = [];

    out = cell(square,square);

    for i = 1 : size(aa,2) 
       for j = 1 : size(bb,2)

           if(i == size(aa,2) && j == size(bb,2))
              out(i,j) = {im(aa(i):row, bb(j):col,:)};
           elseif(j == size(bb,2))
              out(i,j) = {im(aa(i):aa(i+1)-1, bb(j):col,:)}; 
           elseif(i == size(aa,2))
              out(i,j) = {im(aa(i):row, bb(j):bb(j+1)-1,:)};
           else
               out(i,j) = {im(aa(i):aa(i+1)-1, bb(j):bb(j+1)-1,:)};
           end
           temp_mat = [aa(i)-1 bb(j)-1];
           temp = [temp {temp_mat}];
       end
           coordinates = [coordinates; temp];
           temp = [];
    end
    
    threshold = 150;
    comparator = size(out{1,1},1);
    
    while(remaining > 0)
        for i = 1:tempRow-2
            for j = 1:tempCol-2

                if(size(out{i,j},1)==0)
                    coordinates{i,j} = 0;
                    continue;
                end
                
                if(size(out{i+1,j},1) == 0 && size(out{i,j+1},1) == 0)
                    continue;
                elseif(size(out{i+1,j},1) == 0)
                    if(size(out{i,j},1) == size(out{i,j+1},1) && size(out{i,j},1) == comparator)
                        
                        differenceCol = sum(sum(sum(abs(out{i,j} - out{i,j+1}))));
                        if(differenceCol < threshold)
                            out{i,j} = [out{i,j}; out{i,j+1}];
                            out{i,j+1} = {};
                            coordinates{i,j+1} = 0;
                            remaining = remaining -1;
                        else
                            continue
                        end
                        
                    else
                        continue  
                    end
                elseif(size(out{i,j+1},1) == 0)
                    if(size(out{i,j},1) == size(out{i+1,j},1) && size(out{i,j},1) == comparator)
                        differenceRow = sum(sum(sum(abs(out{i,j} - out{i+1,j}))));
                        if(differenceRow < threshold)
                            out{i,j} = [out{i,j}; out{i+1,j}];
                            out{i+1,j} = {};
                            coordinates{i+1,j} = 0;
                            remaining = remaining -1;
                        else
                            continue
                        end
                        
                    else
                        continue  
                    end   
                else
                    if(size(out{i,j},1) ~= size(out{i+1,j},1) && size(out{i,j},1) ~= size(out{i,j+1},1))
                        continue;
                    elseif(size(out{i,j},1) ~= size(out{i+1,j},1) && size(out{i,j},1) == size(out{i,j+1},1))
                        differenceCol = sum(sum(sum(abs(out{i,j} - out{i,j+1}))));
                        
                        if(differenceCol < threshold && size(out{i,j},1) == comparator)
                            out{i,j} = [out{i,j}; out{i,j+1}];
                            out{i,j+1} = {};
                            coordinates{i,j+1} = 0;
                            remaining = remaining -1;
                        else
                            continue
                        end
                    elseif(size(out{i,j},1) == size(out{i+1,j},1) && size(out{i,j},1) ~= size(out{i,j+1},1))   
                        differenceRow = sum(sum(sum(abs(out{i,j} - out{i+1,j}))));
                        
                        if(differenceRow < threshold && size(out{i,j},1) == comparator)
                            out{i,j} = [out{i,j}; out{i+1,j}];
                            out{i+1,j} = {};
                            coordinates{i+1,j} = 0; 
                            remaining = remaining -1;
                        else
                            continue
                        end
                    else
                        %if(size(out{i,j},1) == size(out{i+1,j},1) && size(out{i,j},1) == size(out{i,j+1},1))
                        differenceRow = sum(sum(sum(abs(out{i,j} - out{i+1,j}))));
                        differenceCol = sum(sum(sum(abs(out{i,j} - out{i,j+1}))));

                        if(differenceRow < threshold && size(out{i,j},1) == comparator)
                            out{i,j} = [out{i,j}; out{i+1,j}];
                            out{i+1,j} = {};
                            coordinates{i+1,j} = 0; 
                            remaining = remaining -1;
                        elseif(differenceCol < threshold && size(out{i,j},1) == comparator)
                            out{i,j} = [out{i,j}; out{i,j+1}];
                            out{i,j+1} = {};
                            coordinates{i,j+1} = 0;
                            remaining = remaining -1;
                        else
                            continue;


    %                     if (differenceRow>differenceCol)
    %                         out{i,j} = [out{i,j}; out{i+1,j}];
    %                         out{i+1,j} = {};
    %                         coordinates{i+1,j} = 0;
    %                     else
    %                         out{i,j} = [out{i,j}; out{i,j+1}];
    %                         out{i,j+1} = {};
    %                         coordinates{i,j+1} = 0;
    %                     end
                        end

                        if(remaining ==0)
                            break;
                        end
                    end
                    
                end
   
                if(remaining ==0)
                    break;
                end
            end
            if(remaining ==0)
                break;
            end
        end
        if(remaining ==0)
            break;
        end
        threshold = threshold * 1.2;
    end
end