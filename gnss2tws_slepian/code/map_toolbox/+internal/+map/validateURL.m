function validateURL(parameterName, serverURL)
%validateURL Validate serverURL input
%
%   validateURL(parameterName, serverURL) validates serverURL as valid URL
%   string.  parameterName is a string containing the name for the
%   serverURL parameter. serverURL is validated to be a row vector URL
%   string, containing the protocol, 'http, 'https', or 'file'.

% Copyright 2009-2020 The MathWorks, Inc.

% Validate serverURL.
validateattributes(serverURL, {'char'}, {'nonempty', 'vector', 'row'}, ...
    'validateURL', parameterName);

try
    url = matlab.net.URI(serverURL);
catch e
    error(message('map:validate:invalidURL', parameterName));
end

% Validate the protocol. Note that in the error message, 'file' is not
% included since it is undocumented.
protocols = {'http', 'https','file'};
protocol = char(url.Scheme);
map.internal.assert(any(strcmpi(protocol, protocols)),  ...
    'map:validate:invalidURLProtocol',  parameterName, 'http://', 'https://');

% Verify that a host has been provided.
protocol = [protocol '://'];
map.internal.assert(numel(serverURL) > numel(protocol), ...
    'map:validate:invalidURLHostname', parameterName);
end
