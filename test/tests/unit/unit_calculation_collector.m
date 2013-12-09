classdef unit_calculation_collector < matlab.unittest.TestCase
    properties
        collector;
    end

    methods(TestClassSetup)
        function class_setup_other(testCase)
            addpath('../../../lib/framework/');
        end
    end

    methods(TestMethodSetup)
        function setup(testCase)
            testCase.collector = calculation_collector();
        end
    end

    methods(Test)
        function add_field_for_num(testCase)
            field_name = 'testdata';
            value = 7.21234;
            testCase.collector.add_field(value, field_name);
            testCase.assertEqual(value, testCase.collector.calculated.('testdata'));
        end
        
        function add_field_for_matrix(testCase)
            value = [1,2,3,4,5,6,7,8; 4,5,6,1,3,6,8,124313241];
            testCase.collector.add_field(value, 'testdata');
            testCase.assertEqual(value, testCase.collector.calculated.('testdata'));
        end

        function access_field_if_exists(testCase)
            data = [1,2,3,4,5,6,1];
            testCase.collector.add_field(data, 'testdata');
            testCase.assertEqual(testCase.collector.access_field('testdata'), data);
        end

        function access_field_if_not_exist_gives_empty_matrix(testCase)
            testCase.assertEqual(testCase.collector.access_field('notvaliddata'), []);
        end
    end
end
