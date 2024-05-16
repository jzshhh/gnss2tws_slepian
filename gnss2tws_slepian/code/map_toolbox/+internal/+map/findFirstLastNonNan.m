function [first, last] = findFirstLastNonNan(x)
% Given a vector X containing NaN-delimited sequences of numbers, find the
% indices of the first and last element of each sequence.  X may contain
% runs of multiple NaNs, and X may start or end with one or more NaNs.

% Copyright 2008-2009 The MathWorks, Inc.

n = isnan(x(:));

firstOrPrecededByNaN = [true; n(1:end-1)];
first = find(~n & firstOrPrecededByNaN);

lastOrFollowedByNaN = [n(2:end); true];
last = find(~n & lastOrFollowedByNaN);
