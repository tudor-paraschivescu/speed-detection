%********************************************************************
%
% FILENAME : speedCheck.m
% AUTHOR : Tudor Paraschivescu
% START DATE : 27/09/2016
% DESCRIPTION : Determine the speed of an object from an .avi file.
%				The object must come from left to right.
%				There must be drawn two red lines on the ground
%				and the distance between them must be known.
% INPUT:
%		- fileName: the name (or path) of the video file
%		- RGB: a vector that contains the conditions for column matching.
%				It is a 3 x 1 (or 1 x 3) vector of type int ([0, 255]):
%				- RGB(1) - the minimum amount of red a pixel must have
%				- RGB(2) - the maximum amount of green a pixel must have
%				- RGB(3) - the maximum amount of blue a pixel must have
%		- DISTANCE: the distance in meters between the two lines
%		- p: minimum percentage a pixel must be changed than another
%				pixel to be counted as different
%		- DIF: the minimum percentage in which two columns differ
%				in order to found a new object getting in the frame
%		- spF: speed format ('km/h' or 'm/s')
% OUTPUT:
%		- SPEED: the speed of the object (in either km/h or m/s)
%
%********************************************************************

function [] = checkSpeedRGB(fileName, RGB, DISTANCE, p, DIF, spF)

%	Read the info of the video file:
%	Duration, Name, Path, BitsPerPixel, FrameRate, Height, Width, CurrentTime
	vidInfo = VideoReader(fileName)

%	Initialize the RGB matrix of a frame
	frame = zeros(vidInfo.Height, vidInfo.Width, 3);

%	Get the RGB matrix of the first frame of the video
	frame1 = vidInfo.readFrame;

%	Find the pixels that respect the conditions for column matching
	match = (frame1(:, :, 1) > RGB(1) & frame1(:, :, 2) < RGB(2) & frame1(:, :, 3) < RGB(3));

%	The number of pixels in the frame that respect the conditions
%	sum(match(:))

%	The number of pixels on each column that respect the conditions 
	v = sum(match);

%	Find the two columns between which we measure the speed
%	One is in the left side of the frame, one in the right
	[M col1] = max(v(1 : vidInfo.Width / 2));
	[M col2] = max(v(vidInfo.Width / 2 + 1 : vidInfo.Width));
	col2 = col2 + vidInfo.Width / 2;

%	col1
%	col2

%	-----------------------------------------------------------------
%	*** Add Padding Improvement ***
%	Add x columns to the left and x columns to the right in the areas
%	that will be compared, for better accuracy
%	-----------------------------------------------------------------

%	The variable is - 0 if the object has not been spotted
%					- 1 if the object has reached first column
%					- 2 if the object has reached second column
	position = 0;
	nrFrame = 1;
    SPEED = -1;

	while vidInfo.hasFrame
%		vidInfo.CurrentTime
		nrFrame = nrFrame + 1;
		if position == 2
%			Calculate the time in which the object moved from COL1 to COL2
			TIME = time2 - time1;
%			Calculate speed in m/s
			SPEED = double(DISTANCE) / TIME;
			if strcmp(spF, 'km/h') == 1
%				Transform speed from m/s in km/h
				SPEED = SPEED * 3.6;
			end
			break
		else
			frame = vidInfo.readFrame;
%			columnCompare(frame1(:, col1, :), frame(:, col1, :), p)
%			columnCompare(frame1(:, col2, :), frame(:, col2, :), p)
			if position == 0
				if (columnCompare(frame1(:, col1, :), frame(:, col1, :), p) > DIF)
					disp('The object has reached first column');
					vidInfo.CurrentTime
					nrFrame
					position = 1;
%					time1 is the time when the object reaches column 1
					time1 = vidInfo.CurrentTime;
				end
			else
				if (columnCompare(frame1(:, col2, :), frame(:, col2, :), p) > DIF)
					disp('The object has reached second column');
					vidInfo.CurrentTime
					nrFrame
					position = 2;
%					time2 is the time when the object reaches column 2
					time2 = vidInfo.CurrentTime;
				end
			end
		end
    end

    if SPEED ~= -1
    	disp(strcat('SPEED:', num2str(SPEED), spF));
    else
        disp('Speed - ERROR');
    end
end