function [outPNG] = cjpToPNG(cjp)
    fileID = fopen(cjp,'r');    
    A1 = str2double(fgetl(fileID));
    A2 = str2double(fgetl(fileID));
    
    C = textscan(fileID,'%s');
    
    hexMatrix = horzcat(C{:});
    
    temp = hex2rgb(hexMatrix, 255);
    
    outPNG = fliplr(imrotate(reshape(temp, A1, A2, 3),-90));
    
    fclose(fileID);
end