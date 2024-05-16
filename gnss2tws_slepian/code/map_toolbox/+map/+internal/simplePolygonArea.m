function A = simplePolygonArea(x,y)
% A = simplePolygonArea(x,y) returns twice the area of the simple
% closed polygonal curve with vertices specified by vectors x and y.
% The result is:
%
%    Positive for clockwise vertex order
%    Negative for counter-clockwise vertex order
%    Zero if there are fewer than 3 vertices
%
% Reference:
% https://geometryalgorithms.com/Archive/algorithm_0101/algorithm_0101.html
% (with sign change in order to use clockwise-is-positive convention.)

% Copyright 2018 The MathWorks, Inc.

[x, y] = removeDuplicates(x, y);
x = x - mean(x);
n = numel(x);
if n <= 2
    A = 0;
else
    i = [2:n 1];
    j = [3:n 1 2];
    k = (1:n);
    A = sum(x(i) .* (y(k) - y(j)));
end
A = A/2;

%----------------------------------------------------------------------

function [x, y] = removeDuplicates(x, y)
% ... including duplicate start and end points.

is_closed = ~isempty(x) && (x(1) == x(end)) && (y(1) == y(end));
if is_closed
    x(end) = [];
    y(end) = [];
end

dups = [false; (diff(x(:)) == 0) & (diff(y(:)) == 0)];
x(dups) = [];
y(dups) = [];
