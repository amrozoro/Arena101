using UnityEngine;
using UnityEngine.Audio;
using UnityEngine.UI;

public class AudioManager : MonoBehaviour
{
    public AudioMixer mainMixer;

    public Slider masterSlider, musicSlider, sfxSlider;

    public static float volumeMasterLevel, volumeMusicLevel, volumeSFXLevel;

    public void Start()
    {
        masterSlider.value = volumeMasterLevel;
        ChangeMusicVolume(-80);
        ChangeSFXVolume(-30);
        sfxSlider.value = volumeSFXLevel;
    }

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.M) && !TextBoxScript.inputFieldActive)
        {
            mainMixer.GetFloat("musicVolume", out float value);

            if (value == -80)
            {
                //if currently muted, we unmute
                ChangeMusicVolume(-22);
            }
            else
            {
                //if currently unmuted, we mute
                ChangeMusicVolume(-80);
            }
        }
    }

    public void ChangeMasterVolume(float masterLevel)
    {
        mainMixer.SetFloat("masterVolume", masterLevel);
        masterSlider.value = masterLevel;
        volumeMasterLevel = masterLevel;
    }

    public void ChangeMusicVolume(float musicLevel)
    {
        mainMixer.SetFloat("musicVolume", musicLevel);
        musicSlider.value = musicLevel;
        volumeMusicLevel = musicLevel;
    }

    public void ChangeSFXVolume(float sfxLevel)
    {
        mainMixer.SetFloat("sfxVolume", sfxLevel);
        sfxSlider.value = sfxLevel;
        volumeSFXLevel = sfxLevel;
    }
}
