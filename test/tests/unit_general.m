classdef unit_general < matlab.unittest.TestCase
    methods(TestClassSetup)
        function class_setup_other(testCase)
            addpath('../../lib/framework/');
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
        function test_signal_constructor(testCase)
            a_signal = signal('a signal name', [1,2,3,4]);
            testCase.assertInstanceOf(a_signal, 'signal');
            testCase.assertEqual(a_signal.name, 'a signal name');
            testCase.assertEqual(a_signal.data, [1,2,3,4]);
            testCase.assertEqual(a_signal.flagged, false);
        end

        function test_drop_flag(testCase)
            an_ascii_drop = drop([], 'a_drop_id');
            testCase.assertEqual(an_ascii_drop.flagged, false);
            an_ascii_drop.flag();
            testCase.assertEqual(an_ascii_drop.flagged, true);
            testCase.assertEqual(an_ascii_drop.flagged, true);
            an_ascii_drop.unflag();
            testCase.assertEqual(an_ascii_drop.flagged, false);
        end

       % function test_apply_process(testCase)
       %     a_basic_process = process_basic_process();
       %     testCase.proc.apply_process(testCase.collector,...
       %                                 testCase.Set, a_basic_process);
       %     testCase.assertEqual(a_basic_process.value,...
       %                          testCase.collector.calculated.test);
       % end
        
        function test_drop_set_get_ids(testCase)
            addpath('../mmockito/mmockito/');
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
    end
end
