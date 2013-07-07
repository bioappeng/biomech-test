classdef tests < matlab.unittest.TestCase
    properties
        Set
        drop
        collector
    end
    
    methods(TestClassSetup)
        function classSetup(testCase)
            testCase.Set = dropSet('test/', 0, true);
        end
    end
    
    methods(TestMethodSetup)
        function setup(testCase)
            testCase.drop = testCase.Set.drops(1).Value;
            testCase.collector = parameter_collector();
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
    end
end
