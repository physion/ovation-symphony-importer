%% Create a DataContext
import ovation.*
context = NewDataContext();

%% Retrieve the Experiment object

experiment = context.getObjectWithURI('...experiment URI here...');


%% Find or create the Source protocol

% The source protocol is used to describe the procedure for deriving a
% child Source from the animal Source. In other words, how do you
% get an electrode into a cell within some tissue of an animal?

% Replace this protocol name with the correct name for your Source
% protocol.
protocolName = 'Protocol for deriving cells Sources from Animals';

% Retrieve the named protocol
sourceProtocol = context.getProtocol(protocolName);
if(isempty(sourceProtocol)) % protocol does not exist yet
    
    % Replace the second parameter with your protocol's description, using
    % {VARIABLE_NAME} to denote variables/parameters in the protocol.
    sourceProtocol = context.insertProtocol(protocolName, '...Protocol Document Here...');
end

srcDerivationParameters = struct(); % Any parameters of this protocol such as incubation time, reagent concentrations, etc.?
srcDerivationDeviceParameters = struct(); % Any device parameters?

%% Run the import

% This is to be run from within the ovation-symphony-importer/ directory
pathToData='fixtures';
h5file = '110311Dc1.h5';
metadata_xml = '110311Dc1_metadata.xml';

% Groups will be a list of inserted EpochGroups
groups = SymphonyImport(self.context,...
    fullfile(pwd(), pathToData, h5file),...
    fullfile(pwd(), pathToData, metadata_xml),...
    experiment,...
    sourceProtocol);