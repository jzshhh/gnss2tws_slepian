function checkcmap(map, function_name, variable_name, argument_position)
%CHECKCMAP Check colormap for validity
%
%   CHECKCMAP(MAP,FUNCTION_NAME,VARIABLE_NAME,VARIABLE_ARGUMENT_POSITION)
%   checks to see if MAP is a valid MATLAB colormap.  If it isn't,
%   CHECKCMAP, issues an error message using FUNCTION_NAME, VARIABLE_NAME,
%   and VARIABLE_ARGUMENT_POSITION.  FUNCTION_NAME is the name of the
%   user-level function that is checking the colormap, VARIABLE_NAME is the
%   name of the colormap variable in the documentation for that function,
%   and VARIABLE_ARGUMENT_POSITION is the position of the colormap input
%   argument to that function.

% Copyright 2010 The MathWorks, Inc.

assert(isa(map,'double') && ~isempty(map) && ...
    (ndims(map) == 2) && (size(map,2) == 3) && ~issparse(map), ...
    'map:checkcmap:badMapMatrix',  ...
    ['Function %s expected its %s input argument %s ', ...
    'to be a valid colormap. Valid colormaps must be nonempty, ', ...
    'double, 2-D matrices with 3 columns.'],  ...
    upper(function_name), num2ordinal(argument_position), ...
    upper(variable_name))

assert(all(map(:) >= 0) && all(map(:) <= 1), ...
    'map:checkcmap:badMapValues', ...
    ['Function %s expected its %s input argument %s ', ...
    'to be a valid colormap. Valid colormaps cannot have values ', ...
    'outside the range [0,1].'],  ...
    upper(function_name), num2ordinal(argument_position), ...
    upper(variable_name))    
