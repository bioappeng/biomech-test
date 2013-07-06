classdef tests < matlab.unittest.TestCase
    
    properties
        calcs
        calibs
        Set
        drop
        proc
        collector
    end
    
    methods(TestClassSetup)
        function classSetup(testCase)
            addpath('subprocesses');
            testCase.calcs = {@max_load, @max_accx, @max_accy, @max_accz, @max_loadx, @max_loady, @max_loadz};
            testCase.calibs = {@calib_load, @calib_load_triax, @calib_pos};
            testCase.Set = dropSet('test/', 0, true);
        end
    end
    
    methods(TestMethodSetup)
        function setup(testCase)
            testCase.drop = testCase.Set.drops(1).Value;
            testCase.collector = parameter_collector();
            testCase.proc = processor();
        end
    end
    
    methods(TestMethodTeardown)
        function teardown(testCase)
        end
    end
    
    methods(Test)
        
        function testdropSetConstructor(testCase)
            testCase.assertEqual(testCase.Set.num_drops, length(testCase.Set.drops));
            testCase.assertEqual(testCase.Set.three_axis_load, true);
        end

        function testAddValue_for_Num(testCase)
            field_name = 'test';
            value = 7.21234;
            testCase.collector.add_data(value, field_name);
            testCase.assertEqual(value, testCase.collector.calculated.('test'));
        end
        
        function testAddValue_for_Matrix(testCase)
            field_name = 'test';
            value = [1,2,3,4,5,6,7,8; 4,5,6,1,3,6,8,124313241];
            testCase.collector.add_data(value, field_name);
            testCase.assertEqual(value, testCase.collector.calculated.('test'));
        end

        function testApplyProcess(testCase)
            function basicProcess(collector, dropSet)
                field_name = 'test';
                value = 12341;
                collector.add_data(value, field_name);
            end
            testCase.proc.apply_process(testCase.collector, testCase.Set, @basicProcess);
            testCase.assertEqual(value,testCase.collector.calculated.test);
        end
    end
end
