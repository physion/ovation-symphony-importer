classdef TestSymphonyImport < OvationTestCase
    methods
        
        function self = TestSymphonyImport(name)
            self = self@TestSymphonySuite(name);
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
            
            %% project and experiment
            for i=0:1
                experimentPurpose='Test the Symphony import script works correctly';
                exp = project.insertExperiment(experimentPurpose,...
                    ovation.datetime(2011, 10, 1)...
                    );
                
                groups = SymphonyImport(self.context,...
                    fullfile(pwd(), pathToData, h5file),...
                    fullfile(pwd(), pathToData, metadata_xml),...
                    exp);
                                                
                % Should have inserted one root EpochGroup
                assert(length(groups) == 2);
                
                itr = exp.getEpochsIterable.iterator();
                n = 0;
                while(itr.hasNext())
                    n = n+1;
                    itr.next();
                end
                
                % Should have inserted 20 epochs
                assert(n == 20);
            end
        end
    end
end
