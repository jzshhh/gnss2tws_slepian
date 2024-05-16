function varargout = checkfilename(varargin)
%CHECKFILENAME Check validity of a filename.
%   FULLFILENAME = CHECKFILENAME( ...
%       FILENAME, FUNCTION_NAME, ARGUMENT_POSITION)
%   checks the validity of the FILENAME for reading data and issues a
%   formatted error if the FILENAME is invalid. FULLFILENAME is the
%   absolute pathname of the file.
%
%   FILENAME can be a MATLABPATH relative partial pathname. If the file is
%   not found in the current working directory, CHECKFILENAME searches down
%   MATLAB's search path. The FILENAME must exist with read permission. If
%   FILENAME is a URL address, an error is issued.
%
%   FUNCTION_NAME is a string containing the function name to be used in
%   the formatted error message.
%
%   ARGUMENT_POSITION is a positive integer indicating which input argument
%   is being checked; it is also used in the formatted error message.
%
%   FULLFILENAME = CHECKFILENAME( ...
%       FILENAME, EXT, FUNCTION_NAME, ARGUMENT_POSITION)
%   loops, appending each element of EXT in both upper and lower case,
%   until a valid filename is found; otherwise it will issue an error.  EXT
%   is a string or cell array of character vectors, which may be EMPTY,
%   containing extensions without the '.' character.
%
%   [FULLFILENAME, FID] = CHECKFILENAME(FILENAME, ...) leaves the file
%   FULLFILENAME opened and returns the file identifier.
%
%   [FULLFILENAME, ISURL] = CHECKFILENAME(FILENAME, ..., ALLOWURL) allows
%   FILENAME to be a URL address, if ALLOWURL is true. The address must
%   include the protocol type (e.g., "http://").  In this case,
%   FULLFILENAME is the absolute path to a temporary file copied from the
%   URL location and ISURL is TRUE; otherwise, ISURL is false.  If FILENAME
%   is a URL address, remember to delete FULLFILENAME as it is a temporary
%   copy.

% Copyright 1996-2023 The MathWorks, Inc.

nargoutchk(0, 2)
narginchk(3, 5)

% Validate inputs and outputs.
[filename, ext, function_name, allowURL] = parseInputs(varargin{:});
haveAllowURL = (nargin >= 4) && islogical(varargin{end});

if (contains(filename, '://'))
    % The filename is a URL.
    fullfilename = checkURL(filename, function_name, allowURL);
    nargoutchk(2, 2)
    fid = [];
    isURL = true;
else
    % The filename is a disk filename.
    % fid points to an open file.
    [fullfilename, fid] = checkDiskfilename(filename, ext, function_name);
    isURL = false;

    % Close the file if not requesting a FID output or
    % if using the ALLOWURL syntax.
    needToCloseFile = nargout ~= 2 || haveAllowURL;
    if needToCloseFile
        fclose(fid);
    end
end

needFID = (nargout == 2) && ~haveAllowURL;
needURL = (nargout == 2) &&  haveAllowURL;
optionalOutputs = {fid, isURL};
optionalOutputs([~needFID, ~needURL]) = [];
varargout = [{fullfilename} optionalOutputs];

%-------------------------------------------------------------------------
function [filename, ext, function_name, allowURL] = parseInputs(varargin)

allowURL= false;
switch nargin
   case 3
      % CHECKFILENAME(FILENAME, FUNCTION_NAME, ARGUMENT_POSITION)
      filename = varargin{1};
      function_name = varargin{2};
      pos = varargin{3};
      ext = {''};

   case 4
      filename = varargin{1};
      if islogical(varargin{4})
         % CHECKFILENAME(FILENAME, FUNCTION_NAME, ...
         %               ARGUMENT_POSITION, ALLOWURL)
         function_name = varargin{2};
         pos = varargin{3};
         allowURL = varargin{4};
         ext = {''};
      else
         % CHECKFILENAME(FILENAME, EXT, FUNCTION_NAME, ...)
         %               ARGUMENT_POSITION)
         ext = varargin{2};
         function_name = varargin{3};
         pos = varargin{4};
      end

   case 5
      % CHECKFILENAME(FILENAME, EXT, FUNCTION_NAME, ,...
      %               ARGUMENT_POSITION, ALLOWURL)
      filename = varargin{1};
      if islogical(varargin{5})
         ext = varargin{2};
         function_name = varargin{3};
         pos = varargin{4};
         allowURL = varargin{5};
      else
         error(message("map:validate:invalidInputs","ALLOWURL"))
      end
end

% Verify the inputs
validateattributes(function_name, {'char','string'}, {'scalartext'}, mfilename, 'FUNCTION_NAME');
validateattributes(filename, {'char','string'}, {'nonempty','scalartext'}, function_name, 'FILENAME', pos);
filename = char(filename);

if ~iscellstr(ext) && ~isstring(ext)
   error(message("map:validate:invalidInputs","EXT"))
end

if ~isnumeric(pos)
   error(message("map:validate:invalidInputs","ARGUMENT_POSITION"))
end

%-------------------------------------------------------------------------
function [fullfilename, fid] = ...
   checkDiskfilename(filename, ext, function_name)

% Try to open the filename with read permission.
fid = fopen(filename, 'r');

% Verify the file is opened.
if (fid == -1)
   % The file cannot be opened with read permission.
   % Try to append various extensions and try again.
   found = 0;
   extension = [lower(ext) upper(ext)];
   for p = 1:numel(extension)
      extname = filename + "." + extension{p};
      fid = fopen(extname, 'r');
      if (fid ~= -1)
         % File was found.
         %  Break "for" loop with updated extname.
         found = 1;
         break;
      end
   end

   % Check that some filename+extension combination was found.
   if (~found)
      % Filename could not be opened with 'r' permission
      %  but could exist with write mode or as a MATLAB file
      if isequal(exist(filename,'file'),2)
         % Check to verify NOT a MATLAB file
         if ~(isequal(exist([filename '.m'],'file'),2) || ...
               isequal(exist([filename '.M'],'file'),2))
            % File exists without read mode
               error(message("map:validate:invalidFileMode",...
			     upper(function_name), filename));
         end
      end
      % File does not exist.
      error(message("map:validate:invalidFilename",...
		    upper(function_name), filename));
   end
end

% Return the full pathname if not in pwd.
fullfilename = fopen(fid);
if isequal(exist(fullfile(pwd,fullfilename),'file'),2)
   fullfilename = fullfile(pwd, fullfilename);
end

%-------------------------------------------------------------------------
function fullfilename = checkURL(filename, function_name, allowURL)

if ~allowURL
   error(message("map:validate:filenameIsURL",filename));
end


urltempname = tempname;
try
   fullfilename = websave(urltempname, filename);
catch %#ok<CTCH>
   % The PC will not create urltempname,
   % but Unix will, so delete it if it exists.
   if exist(urltempname, 'file')
      delete(urltempname);
   end
     error(message("map:validate:checkInvalidURL",...
		   upper(function_name), filename));
end

