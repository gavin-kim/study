package dependencyinjection;

import org.aspectj.lang.annotation.SuppressAjWarnings;
import org.junit.Test;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.BeanFactoryUtils;
import org.springframework.beans.factory.xml.XmlBeanFactory;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.core.io.ClassPathResource;


import static org.mockito.Mockito.*;


public class Tester {

    /**
     * Purpose: loose coupling - tightly coupled code is difficult to test and reuse
     *
     *          Knight class is given quests when construction time
     *          Knight class doesn't know anything about which type of Quest
     *          Only xml file know for sure that the implementations are
     *
     * NOTE: When Spring load xml file, It create and set all bean in the xml file
     *
     * Q1. How can you give SlayDragonQuest to BraveKnight?
     * Q2. How can you give a PrintStream to SlayDragonQuest?
     */

    @Test
    public void constructor_injection_directly() {
        Quest mockQuest = mock(Quest.class);    // Create mock quest
        Knight knight = new Knight(mockQuest);  // Inject mock quest
        knight.doQuest();
        verify(mockQuest, times(1)).start();    // Verify how many start() is invoked
    }

    @Test
    public void constructor_injection_with_xml() {

        // Load Spring context from the xml file
        ClassPathXmlApplicationContext context =
            new ClassPathXmlApplicationContext("dependencyinjection/constructor-knight.xml");

        // Get Knight bean
        Knight knight = context.getBean(Knight.class);

        // invoke doQuest()
        knight.doQuest();
        context.close();
    }

    @Test
    public void constructor_injection_java_based() {

        // Load Spring context from Java class
        AnnotationConfigApplicationContext context =
            new AnnotationConfigApplicationContext(KnightConfig.class);

        // Get Knight bean (method looks for @Bean method returns Knight object)
        // NOTE: @Bean method that returns Knight MUST be unique
        Knight knight = context.getBean(Knight.class);

        Knight knight2 = (Knight) context.getBean("k"); // @Bean(name = "k")
        // invoke doQuest()
        knight.doQuest();
        context.close();
    }

    @Test
    public void setter_injection_with_xml() {

        // Load Spring context from the xml file
        ClassPathXmlApplicationContext context =
            new ClassPathXmlApplicationContext("dependencyinjection/setter-knight.xml");

        Knight knight = (Knight) context.getBean("knight");

        knight.doQuest();
    }

    @Test
    @SuppressAjWarnings
    public void prove_difference_between_BeanFactory_and_ApplicationContext() {

        /**!-- BeanFactory doesn't instantiate beans when it loads resources */
        BeanFactory beanFactory =
            new XmlBeanFactory(
                new ClassPathResource("dependencyinjection/constructor-knight.xml"));

        System.out.println("*After creating a container from BeanFactory*");

        Knight knight = (Knight) beanFactory.getBean("knight");

        System.out.println();

        ClassPathXmlApplicationContext applicationContext =
            new ClassPathXmlApplicationContext("dependencyinjection/constructor-knight.xml");

        System.out.println("*After creating a container from ApplicationContext*");

        Knight knight2 = (Knight) applicationContext.getBean("knight");

    }
}
