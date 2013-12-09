classdef unit_general < matlab.unittest.TestCase
    methods(TestClassSetup)
        function class_setup_other(testCase)
            addpath('../../../lib/framework/');
        end
    end

    methods(TestMethodSetup)
        function setup_Sets(testCase)
        end
    end
    
    methods(TestMethodTeardown)
        function teardown(testCase)
        end
    end

    methods(Test)
        function collector_add_field_for_num(testCase)
            collector = calculation_collector();
            field_name = 'testdata';
            value = 7.21234;
            collector.add_field(value, field_name);
            testCase.assertEqual(value, collector.calculated.('testdata'));
        end
        
        function collector_add_field_for_matrix(testCase)
            collector = calculation_collector();
            value = [1,2,3,4,5,6,7,8; 4,5,6,1,3,6,8,124313241];
            collector.add_field(value, 'testdata');
            testCase.assertEqual(value, collector.calculated.('testdata'));
        end

        function collector_access_field_if_exists(testCase)
            collector = calculation_collector();
            data = [1,2,3,4,5,6,1];
            collector.add_field(data, 'testdata');
            testCase.assertEqual(collector.access_field('testdata'), data);
        end

        function collector_access_field_if_not_exist_gives_empty_matrix(testCase)
            collector = calculation_collector();
            testCase.assertEqual(collector.access_field('notvaliddata'), []);
        end

        function dumper_copies_data_from_calculation_collector(testCase)
            non_empty_collector = calculation_collector();
            non_empty_collector.add_field([1;2;3;4;5;6], 'a_field_name');
            dumper = data_dumper();
            dumper.grab_data(non_empty_collector);
            testCase.assertEqual(dumper.data, non_empty_collector.calculated);
        end
    end
end
