function [options, userSupplied, unmatched, dataArgs] = ...
    parsepv(parameterNames, validateFcns, varargin)
%PARSEPV Parse parameter-value pairs
%
%   [OPTIONS, userSupplied, dataArgs] = PARSEPV(parameterNames,
%   validateFcns, VARARGIN) parses VARARGIN and returns the first set of
%   non-string data arguments in the cell array dataArgs. Parameter values
%   in VARARGIN are returned in the scalar structure OPTIONS. OPTIONS
%   contains the fieldnames specified by parameterNames, a cell array of
%   strings. If a parameter in parameterNames is matched in VARARGIN, the
%   value of the parameter is assigned to the fieldname in OPTIONS as a
%   cell array. If the parameter is not matched in VARARGIN, the default
%   value, {' '} is set. If additional parameters in VARARGIN are found
%   that do not match a name in parameterNames, an error is issued.
%
%   The output userSupplied is a scalar struct array indicating true if a
%   parameter-value pair is supplied in VARARGIN, else false. The
%   fieldnames of userSupplied match the field names of OPTIONS and 
%   parameterNames. 
%
%   dataArgs contains the first set of non-string arguments of VARARGIN.
%   Specifically, if the first string-valued argument is VARARGIN{N}, then
%   dataArgs equals VARARGIN{1:(N-1)}.
%
%   unmatched is a cell array of any unmatched parameter-value pairs,
%   specifically, unmatched contains what is left over from VARARGIN after
%   extracting parameter names and values, and removing dataArgs.
%
%   parameterNames is a cell array of string parameter names. validateFcns
%   is cell array matching in size to parameterNames. validateFcns contains
%   function handles to validate the parameter value. Each function takes
%   two inputs, the value of the parameter as a cell array and the
%   parameter name as a string. The output of validateFcns is the field
%   value of the OPTIONS structure.

% Copyright 2009-2015 The MathWorks, Inc.

% Parse varargin for parameter/value pairs. Return the parameters as field
% names in options. Remove the pairs and return the result in dataArgs.

% Get the number of data arguments from varargin.
numDataArgs = internal.map.getNumberOfDataArgs(varargin{:});

% Return in dataArgs the non-string data input.
dataArgs = varargin(1:numDataArgs);

% Create a cell array of default parameterValues.
parameterValues = cell(1, numel(parameterNames));
parameterValues(1:end) = {{' '}};

% Create the default scalar options structure.
options = cell2struct(parameterValues, parameterNames, 2);

% Create the scalar userSupplied structure.
defaultValues = cell(1,numel(parameterNames));
defaultValues(1:end) = {false};
userSupplied = cell2struct(defaultValues, parameterNames, 2);

if numDataArgs < numel(varargin)
    % Obtain the parameter/value pairs.
    pvpairs = varargin(numDataArgs+1:end);

    % Assign the options and userSupplied fields from the inputs.
    [options, userSupplied, unmatched] = assignOptionsFromInputs( ...
        options, userSupplied, pvpairs, parameterNames, validateFcns);
else
    unmatched = {};
end

%--------------------------------------------------------------------------

function [options, userSupplied, pvpairs] = assignOptionsFromInputs( ...
    options, userSupplied, pvpairs, parameterNames, validateFcns)
% Based on the inputs from the command line, assign the fields of the
% options and userSupplied struct.

% Assign the default value for a parameter if not specified.
default = 'defaultStringValue00';

% Assign the default space value for KML tags.
defaultSpace = ' ';

internal.map.checkNameValuePairs(pvpairs{:})

% Loop through each parameterName and validate the value.
for k=1:numel(parameterNames)

    % Set the parameterName from the parameterNames list.
    parameterName = parameterNames{k};

    % Obtain the value of the parameter.
    [value, pvpairs] = ...
        map.internal.findNameValuePair(parameterName, default, pvpairs{:});

    % If the value is not the default, then it is userSupplied.
    userSupplied.(parameterName) = ~isequal(value, default);

    % If the value is supplied by the user, then validate it, otherwise,
    % set the value to the defaultSpace character.
    if userSupplied.(parameterName)
        value = validateFcns{k}(value);
    else
        value = {defaultSpace};
    end

    % Add the parameter value to the options structure.
    options.(parameterName) = value;
end
