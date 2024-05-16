function numArgs = getNumberOfDataArgs(varargin)
%GETNUMBEROFDATAARGS Return number to first string input
%
%   NUMARGS = getNumberOfDataArgs(VARARGIN) returns the number of arguments
%   preceding the first string-valued argument. If VARARGIN is empty or no
%   string arguments are found, NUMARGS is 0.
%
%   See also PARSEPV.

% Copyright 2009-2017 The MathWorks, Inc.

numArgs = nargin;
for i=1:nargin
   if ischar(varargin{i}) || isstring(varargin{i})
      numArgs = i-1;
      return;
   end
end
