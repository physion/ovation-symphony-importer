classdef TestSymphonyImport < MatlabTestCase
    methods
        
        function self = TestSymphonyImport(name)
            self = self@MatlabTestCase(name);
        end
        
        function groups = runImport(self, context, project, pathToData,...
                h5file, metadata_xml,  n_groups, n_root_group_epochs)

            import ovation.*;
            
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
                assert(length(groups) == n_groups);
                
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
                assert(n == n_root_group_epochs);
            end
        end

        function testIntegration1(self)
            import ovation.*;
            context = self.context;
            project = context.insertProject('Symphony Import Integration Test',...
                'test Symphony import code',...
                ovation.datetime(2010, 6, 23));
            
            pathToData='../fixtures';
            h5file = '110311Dc1.h5';
            metadata_xml = '110311Dc1_metadata.xml'; 
            
            runImport(context, project, pathToData, h5file, metadata_xml, 2, 20)
        end

        function testIntegration2(self)
            import ovation.*;
            context = self.context;
            project = context.insertProject('Symphony Import Integration Test',...
                'test Symphony import code',...
                ovation.datetime(2010, 6, 23));
            
            pathToData='../fixtures';
            h5file = '081213Ac1.h5';
            metadata_xml = '081213Ac1_metadata.xml'; 
            
            groups = it2array(runImport(context, project, pathToData, h5file, metadata_xml, 1, 63));
            
            child_groups = groups(1).getEpochGroups();
            assert(1 == length(it2array(child_groups)));
            n = 0;
            while(child_groups.hasNext())
                epochGroup = child_groups.next();
                eItr = epochGroup.getEpochs().iterator();
                while(eItr.hasNext())
                    n = n+1;
                    eItr.next();
                end
            end
            
            assert(11 == n);
        end
    end
end
