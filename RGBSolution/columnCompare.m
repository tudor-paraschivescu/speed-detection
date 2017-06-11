% A and B are columns from an image of size (x, 1, 3)
% A and B must be of type int and between 0 and 255
% p is the minimum percentage a pixel must be changed
% than another pixel to be counted as different
% DIFFPRCTG is the percentage of difference between the columns
function [DIFFPRCTG] = columnCompare(A, B, p)

	[x y z] = size(A);

%	The Euclidean Distance in the RGB colour space
	euclidDistance = sqrt(sum((A - B) .^ 2, 3));
%	The percentage each pixel is different from the other one
%	255 * sqrt(3) represents the maximum Euclidean Distance
	prctg = euclidDistance ./ (255 * sqrt(3));

	DIFFPRCTG = double(sum(prctg > p)) / x;

end