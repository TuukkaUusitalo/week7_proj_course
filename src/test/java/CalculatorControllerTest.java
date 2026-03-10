import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;

class CalculatorControllerTest {

    @Test
    void testValidNumbers() {
        CalculatorController controller = new CalculatorController();
        String result = controller.calculate("4", "5");
        assertEquals("Sum: 9.0, Product: 20.0", result);
    }

    @Test
    void testInvalidNumber() {
        CalculatorController controller = new CalculatorController();
        String result = controller.calculate("abc", "5");
        assertEquals("Please enter valid numbers!", result);
    }

    @Test
    void testDivisionByZero() {
        CalculatorController controller = new CalculatorController();
        String result = controller.calculate("4", "0");
        assertEquals("Sum: 4.0, Product: 0.0", result);
    }
}