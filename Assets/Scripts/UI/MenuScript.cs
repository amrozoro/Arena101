using UnityEngine;
using UnityEngine.SceneManagement;

public class MenuScript : MonoBehaviour
{
    public static MenuScript Instance;
    public GameObject[] menus = new GameObject[3];
    public string gameSceneName;

    private void Awake()
    {
        Instance = this;
    }

    private void Start()
    {
        menus[0].SetActive(true);

        menus[1].SetActive(false);

        menus[2].SetActive(false);
    }

    public void StartGame()
    {
        SceneManager.LoadScene(gameSceneName);
    }

    public void QuitGame()
    {
        Application.Quit();
    }
}
