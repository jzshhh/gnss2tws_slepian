function tf = ccwRingsAreUnenclosed(x, y)
% True if and only if the polygon defined by x and y includes one or
% more counter-clockwise rings that are not enclosed by a clockwise ring.

% Copyright 2009-2022 The MathWorks, Inc.

cw = ispolycw(x,y);
if any(~cw)
    if all(~cw)
        % All rings are counter-clockwise.
        tf = true;
    else
        % There's a combination of clockwise and counter-clockwise rings.
        [first, last] = internal.map.findFirstLastNonNan(x);
        
        % Isolate the clockwise rings. In the two instances below where
        % we update numVertices or our position (n) in the xcw, ycw
        % arrays, we add 2 to account for the last vertex in the current
        % ring and the NaN that follows it.
        firstcw = first(cw);
        lastcw = last(cw);
        numVertices = sum(lastcw - firstcw + 2);  % Last vertex and NaN
        xcw = NaN(numVertices,1);
        ycw = NaN(numVertices,1);
        n = 1;
        for k = 1:numel(firstcw)
            m = n + lastcw(k) - firstcw(k);
            xcw(n:m) = x(firstcw(k):lastcw(k));
            ycw(n:m) = y(firstcw(k):lastcw(k));
            n = m + 2;  % Last vertex and NaN
        end
        
        % Check the first element of each counter-clockwise ring to see if
        % it's contained in a clockwise ring.
        w = warning("off","MATLAB:inpolygon:ModelingWorldLower");
        c = onCleanup(@() warning(w));
        tf = ~all(inpolygon(x(first(~cw)), y(first(~cw)), xcw, ycw));
    end
else
    % There are no counter-clockwise rings at all.
    tf = false;
end
