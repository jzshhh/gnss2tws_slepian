function checkNameValuePairs(varargin)
%CHECKNAMEVALUEPAIRS Check name-value pairs 
%
%   checkNameValuePairs(VARARGIN) checks and validates that VARARGIN 
%   consists of name-value pairs. If not, an error is issued.

% Copyright 2009-2018 The MathWorks, Inc.

if ~isempty(varargin)
   if rem(length(varargin),2)
      error('map:checkNameValuePairs:invalidPairs', ...
          getString(message('map:validate:invalidPairs')))
   end
   
   params = varargin(1:2:end);
   for k=1:length(params)
      if ~ischar(params{k})
         error('map:checkNameValuePairs:invalidParameterString', ...
             getString(message('map:validate:invalidParameterType',num2ordinal(k))))
      end
   end
end
