classdef TestSymphonyImport < MatlabTestCase
    methods
        
        function self = TestSymphonyImport(name)
            self = self@MatlabTestCase(name);
        end
        
        function testIntegration(self)
            import ovation.*;
            context = self.context;
            project = context.insertProject('Symphony Import Integration Test',...
                'test Symphony import code',...
                ovation.datetime(2010, 6, 23));
            
            pathToData='../fixtures';
            h5file = '110311Dc1.h5';
            metadata_xml = '110311Dc1_metadata.xml'; 
            
            sourceProtocol = 'source-protocol';
            context.insertProtocol(sourceProtocol, '<protocol doc>');
            
            %% project and experiment
            for i=0:1
                experimentPurpose='Test the Symphony import script works correctly';
                exp = project.insertExperiment(experimentPurpose,...
                    ovation.datetime(2011, 10, 1)...
                    );
                
                groups = SymphonyImport(self.context,...
                    fullfile(pwd(), pathToData, h5file),...
                    fullfile(pwd(), pathToData, metadata_xml),...
                    exp,...
                    sourceProtocol);
                                                
                % Should have inserted one root EpochGroup
                assert(length(groups) == 2);
                
                itr = exp.getEpochGroups().iterator();
                n = 0;
                while(itr.hasNext())
                    epochGroup = itr.next();
                    eItr = epochGroup.getEpochs().iterator();
                    while(eItr.hasNext())
                        n = n+1;
                        eItr.next();
                    end
                end
                
                % Should have inserted 20 epochs
                disp([num2str(n) ' Epochs imported']);
                assert(n == 20);
            end
        end
    end
end
