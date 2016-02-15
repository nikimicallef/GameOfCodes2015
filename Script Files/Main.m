function Main(target_file, composition_images, rectangle_count, collage_output_file)
    tic;
    disp('Method now executing');
    png_target_file = cjpToPNG(target_file);
    
    png_composition_images = compExtract(composition_images);

    clg_output =fitter(png_target_file,png_composition_images,str2double(rectangle_count));
    
    dlmwrite(collage_output_file, clg_output, 'newline', 'pc');
    toc;
end
