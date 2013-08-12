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
        function signal_should_have_correct_properties_when_constructed(testCase)
            a_signal = signal('a signal name', [1,2,3,4]);
            testCase.assertInstanceOf(a_signal, 'signal');
            testCase.assertEqual(a_signal.name, 'a signal name');
            testCase.assertEqual(a_signal.data, [1,2,3,4]);
            testCase.assertEqual(a_signal.flagged, false);
        end

        function drop_set_should_have_correct_num_drops_when_created(testCase)
            drop1 = drop([], 'one');
            drop2 = drop([], 'two');
            drop3 = drop([], 'three');
            drops(1).Value = drop1;
            drops(2).Value = drop2;
            drops(3).Value = drop3;
            a_drop_set = drop_set(drops);
            testCase.assertEqual(a_drop_set.num_drops, 3);
        end

        function drop_set_get_drop_should_return_valid_and_correct_drop(testCase)
            drop1 = drop([], 'one');
            drop2 = drop([], 'two');
            drop3 = drop([], 'three');
            drops(1).Value = drop1;
            drops(2).Value = drop2;
            drops(3).Value = drop3;
            a_drop_set = drop_set(drops);
            a_got_drop = a_drop_set.get_drop(2);
            testCase.assertInstanceOf(a_got_drop, 'drop');
            testCase.assertEqual(a_got_drop, drop2);
        end

        function drop_flag_unflag_should_behave_as_expected(testCase)
            an_ascii_drop = drop([], 'a_drop_id');
            testCase.assertEqual(an_ascii_drop.flagged, false);
            an_ascii_drop.flag();
            testCase.assertEqual(an_ascii_drop.flagged, true);
            testCase.assertEqual(an_ascii_drop.flagged, true);
            an_ascii_drop.unflag();
            testCase.assertEqual(an_ascii_drop.flagged, false);
        end

        function drop_set_get_ids_should_return_cell_array_of_correct_drop_ids(testCase)
            addpath('../../mmockito/mmockito/');
            mock_drop1 = Mock();
            mock_drop2 = Mock();
            mock_drop3 = Mock();
            mock_drop1.when.get_id().thenReturn('one');
            mock_drop2.when.get_id().thenReturn('two');
            mock_drop3.when.get_id().thenReturn('three');
            drops(1).Value = mock_drop1;
            drops(2).Value = mock_drop2;
            drops(3).Value = mock_drop3;
            a_drop_set = drop_set(drops);
            ids = a_drop_set.drop_ids();
            testCase.assertEqual(ids, {'one', 'two', 'three'});
        end

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
