function tf = ispolycw(x, y)
%ISPOLYCW True if polygon vertices are in clockwise order
%
%   TF = ISPOLYCW(X, Y) returns true if the polygonal contour vertices 
%   represented by X and Y are ordered in the clockwise direction.  X and Y
%   are numeric vectors with the same number of elements.
%
%   Alternatively, X and Y can contain multiple contours, either in
%   NaN-separated vector form or in cell array form.  In that case,
%   ISPOLYCW returns a logical array containing one true or false value
%   per contour.
%
%   ISPOLYCW always returns true for polygonal contours containing two or
%   fewer vertices.
%
%   Vertex ordering is not well defined for self-intersecting polygonal
%   contours (e.g., "bowties"), but ISPOLYCW uses a signed area test which
%   is robust with respect to self-intersection defects localized to a few
%   vertices near the edge of a relatively large polygon.
%
%   Class Support
%   -------------
%   X and Y may be any numeric class.
%
%   Example
%   -------
%   Orientation of a square:
%
%       x = [0 1 1 0 0];
%       y = [0 0 1 1 0];
%       ispolycw(x, y)                     % Returns 0
%       ispolycw(fliplr(x), fliplr(y))     % Returns 1
%
%   See also POLY2CW, POLY2CCW, POLYSHAPE

% Copyright 2004-2018 The MathWorks, Inc.

if isempty(x)
   tf = true;
elseif iscell(x)
    tf = false(size(x));
    for k = 1:numel(x)
        tf(k) = (map.internal.simplePolygonArea(x{k}, y{k}) >= 0);
    end
else
    checkxy(x, y, mfilename, 'X', 'Y', 1, 2)
    [first, last] = internal.map.findFirstLastNonNan(x);
    numParts = numel(first);
    if isrow(x)
        tf = false(1,numParts);
    else
        tf = false(numParts,1);
    end
    for k = 1:numParts
        s = first(k);
        e = last(k);
        tf(k) = (map.internal.simplePolygonArea(x(s:e), y(s:e)) >= 0);
    end
end
