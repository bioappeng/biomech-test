classdef test_general < matlab.unittest.TestCase
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
        function test_signal_constructor(testCase)
            a_signal = signal('a signal name', [1,2,3,4]);
            testCase.assertInstanceOf(a_signal, 'signal');
            testCase.assertEqual(a_signal.name, 'a signal name');
            testCase.assertEqual(a_signal.data, [1,2,3,4]);
            testCase.assertEqual(a_signal.flagged, false);
        end
        
       % function test_drop_set_get_ids(testCase)
       %     ids = testCase.asciiSet.drop_ids();
       %     testCase.assertEqual(ids{1}, testCase.asciiSet.drops(1).Value.id);
       % end

       % function test_access_drop_method_correct(testCase)
       %     valid_drop = testCase.asciiSet.drops(2).Value;
       %     got_drop = testCase.asciiSet.get_drop(2);
       %     testCase.assertInstanceOf(got_drop, 'drop');
       %     testCase.assertSameHandle(got_drop, valid_drop);
       % end

       % function test_drop_ascii_flag(testCase)
       %     an_ascii_drop = testCase.asciiSet.drops(1).Value;
       %     testCase.assertEqual(an_ascii_drop.flagged, false);
       %     an_ascii_drop.flag();
       %     testCase.assertEqual(an_ascii_drop.flagged, true);
       %     testCase.assertEqual(an_ascii_drop.flagged, true);
       %     an_ascii_drop.unflag();
       %     testCase.assertEqual(an_ascii_drop.flagged, false);
       % end

       % function test_drop_mat_flag(testCase)
       %     a_mat_drop = testCase.matSet.drops(1).Value;
       %     testCase.assertEqual(a_mat_drop.flagged, false);
       %     a_mat_drop.flag();
       %     testCase.assertEqual(a_mat_drop.flagged, true);
       %     testCase.assertEqual(a_mat_drop.flagged, true);
       %     a_mat_drop.unflag();
       %     testCase.assertEqual(a_mat_drop.flagged, false);
       % end
    end
end
