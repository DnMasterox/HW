# coding=utf-8
"""
<ul>
  <h1><b>Math operations</b></h1>
   <i>This library contains basic mathematical functions with casting types.</i>
</ul>
"""
ROBOT_LIBRARY_DOC_FORMAT = 'HTML'


def add(a, b):
    """
    <b>Math Function of addition of numbers.</b>
    <br><i>Example:</i>
    <table border="2">
    <tr>
    <th>a = 1</th>
    <tr>
    <th>b = 2</th>
    </tr>
    <tr>
    <td>add(a, b) = 3</td>
    </tr>
    </table>
    """
    return int(a) + int(b)


def subtract(a, b):
    """
        <b>Function of subtraction of numbers.</b>
        <br><i>Example:</i>
        <table border="2">
        <tr>
        <th>a = 2</th>
        <tr>
        <th>b = 1</th>
        </tr>
        <tr>
        <td>subtract(a, b) = 1</td>
        </tr>
        </table>
        """
    return int(a) - int(b)


def divide(a, b):
    """
            <b>Function of division of numbers.</b>
            <br><i>Example:</i>
            <table border="2">
            <tr>
            <th>a = 20</th>
            <tr>
            <th>b = 2</th>
            </tr>
            <tr>
            <td>divide(a, b) = 10</td>
            </tr>
            </table>
            """
    return float(a) / float(b)


def multiply(a, b):
    """
                <b>The function of multiplication of numbers.</b>
                <br><i>Example:</i>
                <table border="2">
                <tr>
                <th>a = 2</th>
                <tr>
                <th>b = 2</th>
                </tr>
                <tr>
                <td>multiply(a, b) = 4</td>
                </tr>
                </table>
                """
    return float(a) * float(b)
