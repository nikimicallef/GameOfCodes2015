function [imOut] = compExtract(inpTXT)
    fileID2 = fopen(inpTXT,'r');
    
    C = textscan(fileID2,'%s');
    
    hexMatrix = horzcat(C{:});
    
    fclose(fileID2);

    for i = 1:size(hexMatrix,1)
        imOut{1,i} = cjpToPNG(char(hexMatrix(i,1)));
    end
end