function R = convertToGeoRasterRef( ...
    R, rasterSize, angleUnits, func_name, var_name_R, arg_pos)
%convertToGeoRasterRef Convert referencing vector or matrix
%
%   R = convertToGeoRasterRef(R, rasterSize, angleUnits, func_name, ...
%   var_name_R, arg_pos) converts referencing vector or matrix R to a
%   geographic raster reference object.  R may be any valid referencing
%   vector, as long as the cell size 1/R(1), northwest corner latitude
%   R(2), and northwest corner longitude R(3) lead to valid latitude and
%   longitude limits when combined with the rasterSize vector.
%   Alternatively, R may be any valid referencing matrix subject to the
%   constraints that (1) it leads to valid latitude and longitude limits
%   when combined with rasterSize and (2) its columns and rows are aligned
%   with meridians and parallels, respectively. The latter condition is
%   true only when the 1,1 and 2,2 elements of R vanish. Finally, R may
%   already be a valid geographic raster reference object, with a
%   RasterInterpretation of 'cells' and with RasterSize and AngleUnit
%   properties that are consistent with the 2nd and 3rd inputs passed to
%   this function.

% Copyright 2009-2013 The MathWorks, Inc.

if numel(R) == 3
    R = refvecToGeoRasterReference(R, rasterSize, func_name, var_name_R, arg_pos);
elseif isequal(size(R), [3 2])
    R = refmatToGeoRasterReference(R, rasterSize, func_name, var_name_R, arg_pos);
else
    validateattributes(rasterSize, {'double'}, {'row','positive','integer'});
    assert(numel(rasterSize) > 1, ...
        'map:convertToGeoRasterRef:notSizeVector', ...
        'The %s value supplied to function %s must have at least two elements.', ...
        'rasterSize', func_name)
    
    angleUnits = checkangleunits(angleUnits);
    if strcmp(angleUnits,'degrees')
        angleUnit = 'degree';
    end
    
    assert( ...
        validGeoRasterReference(R, rasterSize, angleUnit), ...
        'map:convertToGeoRasterRef:expectedRefvecOrRefmat', ...
        ['Function %s expected input argument %d, ''%s'',' ...
        ' to be a 3-element referencing vector, a 3-by-2 referencing matrix,', ...
        ' or a (scalar) geographic raster reference object.'], ...
        upper(func_name), arg_pos, var_name_R)
end

%------------------------------------------------------------------------

function tf = validGeoRasterReference(R, rasterSize, angleUnit)
% Return true if R has RasterSize, and AngleUnit properties that are
% consistent with the values provided.

if ~isscalar(R) || ~isobject(R)
    tf = false;
else
    % So far, so good: R is an object. Now see if it has with the
    % properties we expect, then see if those properties have the values
    % we expect.
    try
        R_coordinateSystemType = R.CoordinateSystemType;
        R_rasterSize           = R.RasterSize;
        R_angleUnit            = R.AngleUnit;        
        tf = true;
    catch e
        if any(strcmp(e.identifier, ...
            {'MATLAB:noSuchMethodOrField','MATLAB:class:InvalidProperty'}))
            % R is an object, but it  doesn't support the interface we
            % expected. This is very likely a case of invalid input.
            tf = false;
        else
            % It's unlikely that R is invalid. It's much more likely
            % that something unexpected is wrong in the class and
            % supporting code that implements R.
            rethrow(e)
        end
    end   
end

if tf
    assert(strcmp(R_coordinateSystemType, 'geographic'), ...
        'map:convertToGeoRasterRef:unexpectedPropertyValue', ...
        '%s have value %s instead of %s.', ...
        'R.CoordinateSystemType', R_coordinateSystemType, 'geographic')
        
    assert(isequal(R_rasterSize, rasterSize([1 2])), ...
        'map:convertToGeoRasterRef:sizeMismatch', ...
        '%s is inconsistent with %s.', 'R.RasterSize', 'rasterSize')
    
    assert(strcmp(R_angleUnit, angleUnit), ...
       'map:convertToGeoRasterRef:angleUnitsMismatch', ...
       '%s is inconsistent with ''%s.''', 'R.AngleUnit', angleUnit)
end
