classdef unit_other < matlab.unittest.TestCase
    methods(TestClassSetup)
        function class_setup_other(testCase)
            addpath('../../../lib/framework/');
        end
    end

    methods(Test)
        function dumper_copies_data_from_calculation_collector(testCase)
            non_empty_collector = calculation_collector();
            non_empty_collector.add_field([1;2;3;4;5;6], 'a_field_name');
            dumper = data_dumper();
            dumper.grab_data(non_empty_collector);
            testCase.assertEqual(dumper.data, non_empty_collector.calculated);
        end
    end
end
