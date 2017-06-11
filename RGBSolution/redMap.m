function [] = redMap(fileName, RGB)

	vidInfo = VideoReader(fileName);
	frame1 = vidInfo.readFrame;
    
	match = (frame1(:, :, 1) > RGB(1) & frame1(:, :, 2) < RGB(2) & frame1(:, :, 3) < RGB(3));

	Map(:, :, 1) = match .* 255;
	Map(:, :, 2) = zeros(vidInfo.Height, vidInfo.Width);
	Map(:, :, 3) = zeros(vidInfo.Height, vidInfo.Width);

	nameWithoutExtension = strtok(fileName, '.');

	imwrite(Map, strcat(nameWithoutExtension, '_redMap.png'));

end