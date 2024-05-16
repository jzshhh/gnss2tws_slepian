function type = getCoordRefSysCodeType(code)
%getCoordRefSysCodeType Obtain type of coordinate reference system
%
%   TYPE = getCoordRefSysCodeType(CODE) returns the type of coordinate
%   reference system referenced by CODE. CODE is a numeric scalar value
%   representing a code number for an EPSG projection. TYPE is returned as
%   a string with one of the following values indicating the type of
%   coordinate reference system the code defines:
%
%       Value               Type of projection
%     -------------    ------------------------------------
%     'projected'    - projected  coordinate system
%     'geographic'   - geographic coordinate system
%     'invalid'      - code is not numeric, scalar, or finite
%     'user-defined' - user-defined code number (32767)
%     'unknown'      - valid input but not found in database

% Copyright 2011-2020 The MathWorks, Inc.

isValidCode = isnumeric(code) && ~issparse(code) && isscalar(code) ...
    && ~islogical(code) && isfinite(code);

if ~isValidCode
    type = 'invalid';
    
elseif any(code == getGeographicCodes)
    type = 'geographic';
    
elseif any(code == getProjectedCodes)
    type = 'projected';
    
elseif code == 32767
    type = 'user-defined';
    
else
    type = 'unknown';
end

%--------------------------------------------------------------------------

function codes = getGeographicCodes
% Return an array of numbers representing geographic coordinate systems.

persistent geographicCodes
if isempty(geographicCodes)
   geographicCodes = map.internal.epsgread('geodetic_crs','codes');
end
codes = geographicCodes;
   
%--------------------------------------------------------------------------

function codes = getProjectedCodes
% Return an array of numbers representing projected coordinate system.

persistent projectedCodes
if isempty(projectedCodes)
    projectedCodes = map.internal.epsgread('projected_crs','codes');
end
codes = projectedCodes;
