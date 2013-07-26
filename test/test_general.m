classdef test_general < matlab.unittest.TestCase
    properties
        asciiSet 
        matSet
    end
    
    methods(TestClassSetup)
        function class_setup_other(testCase)
            addpath('../lib/');
        end
    end
    
    methods(TestMethodSetup)
        function setup_Sets(testCase)
            testCase.asciiSet = dropSet('../test/data/small_data/ascii/', 0, true, true);
            testCase.matSet = dropSet('../test/data/small_data/mat/test.mat', 0, true, false);
        end
    end
    
    methods(TestMethodTeardown)
        function teardown(testCase)
            testCase.asciiSet.delete();
            testCase.matSet.delete();
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

        function test_dropSet_constructor_ascii(testCase)
            testCase.assertInstanceOf(testCase.asciiSet, 'dropSet');
            testCase.assertNotEmpty(testCase.asciiSet.drops);
            testCase.assertEqual(testCase.asciiSet.num_drops, length(testCase.asciiSet.drops));
            testCase.assertEqual(testCase.asciiSet.three_axis_load, true);
        end
        
        function test_dropSet_get_ids(testCase)
            ids = testCase.asciiSet.drop_ids();
            testCase.assertEqual(ids{1}, testCase.asciiSet.drops(1).Value.id);
        end

        function test_dropSet_constructor_mat(testCase)
            testCase.assertInstanceOf(testCase.matSet, 'dropSet');
            testCase.assertNotEmpty(testCase.matSet.drops);
            testCase.assertEqual(testCase.matSet.num_drops, length(testCase.matSet.drops));
            testCase.assertEqual(testCase.matSet.three_axis_load, true);
        end

        function test_drop_constructor_ascii(testCase)
            an_ascii_drop = testCase.asciiSet.drops(1).Value;
            testCase.assertEqual(an_ascii_drop.id, 'TT5_14_091555');
            testCase.assertInstanceOf(an_ascii_drop, 'asciiDrop');
            testCase.assertNotEmpty(an_ascii_drop.pot.data);
            testCase.assertNotEmpty(an_ascii_drop.accy.data);
        end

        function test_drop_constructor_mat(testCase)
            a_mat_drop = testCase.matSet.drops(3).Value;
            testCase.assertInstanceOf(a_mat_drop, 'matDrop');
            testCase.assertNotEmpty(a_mat_drop.pot.data);
            testCase.assertNotEmpty(a_mat_drop.accy.data);
        end

        function test_drop_ascii_flag(testCase)
            an_ascii_drop = testCase.asciiSet.drops(1).Value;
            testCase.assertEqual(an_ascii_drop.flagged, false);
            an_ascii_drop.flag();
            testCase.assertEqual(an_ascii_drop.flagged, true);
            testCase.assertEqual(an_ascii_drop.flagged, true);
            an_ascii_drop.unflag();
            testCase.assertEqual(an_ascii_drop.flagged, false);
        end

        function test_drop_mat_flag(testCase)
            a_mat_drop = testCase.matSet.drops(1).Value;
            testCase.assertEqual(a_mat_drop.flagged, false);
            a_mat_drop.flag();
            testCase.assertEqual(a_mat_drop.flagged, true);
            testCase.assertEqual(a_mat_drop.flagged, true);
            a_mat_drop.unflag();
            testCase.assertEqual(a_mat_drop.flagged, false);
        end
    end
end
