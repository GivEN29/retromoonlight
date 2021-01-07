#!/bin/python3

"""
Script to generate a launch script for each game available in moonlight
"""
import sys
import os
import stat

RefreshListScript = 'Refresh.sh'
BashHeader = '#!/bin/bash\n'
StreamStrings = {
                 "1080p": 'moonlight stream -1080 -fps 60 -bitrate 50000 -codec h265 -app',
                 "4k": 'moonlight stream -4k -fps 60 -bitrate 50000 -codec h265 -app'
                }
roms_directory = '/home/pi/RetroPie/roms/moonlight/'
sanitization_tokens = {":": ""," ": "_"}


def clear_directory(folder_path):
    """
    Clears the directory of old game launching scripts
    :param folder_path: The path to the folder to clear
    """
    for the_file in os.listdir(folder_path):
        try:
            file_path = os.path.join(folder_path, the_file)
            if os.path.isfile(file_path) \
                and the_file != RefreshListScript \
                and not the_file.endswith(('.txt', 'py')):
                    os.unlink(file_path)
        except Exception as e:
            print(e)


def read_games_list(file_path):
    """
    Reads the contents of a file
    :param file_path: path of the file to read in
    :return: contents of the file
    """
    input_data = ""
    if os.path.isfile(file_path):
        f = open(file_path, "r")
        input_data = f.readlines()
        f.close()
    return input_data


def create_script(game_title, stream_string):
    """
    Creates the script to run a game title
    :param game_title: The name of the game to launch
    :param stream_string: The Moonlight command to launch
    """
    script = f"{BashHeader}{stream_string} \"{game_title}\""
    print('\nCreating a script for {}:'.format(game_title))
    print(script)
    return script


def write_script(script, resolution, game_title, dry_run=False):
    """
    Writes a script string to disk
    :param script: The string to be written as the script
    :param resolution: The resolution at which the game will be streamed
    :param game_title: The game title to be used as the file name
    """
    try:
        script_name = f"{roms_directory}{game_title}_{resolution}.sh"
        print(f"Writing {script_name} to disk... ")
        if not dry_run:
            f = open(script_name, "w+")
            f.write(script)
            f.close()

            st = os.stat(script_name)
            os.chmod(script_name, st.st_mode | stat.S_IEXEC)
    except Exception as write_exception:
        print(write_exception)


def sanitize(game_name):
    """
    Removes unwanted characters from a game's name
    :param game_name: Moonlight game name identifier
    """
    sanitized_game_name = game_name
    for token in sanitization_tokens:
        replacement = sanitization_tokens[token]
        sanitized_game_name = sanitized_game_name.replace(token, replacement)
    return sanitized_game_name


try:
    moonlight_games = read_games_list(sys.argv[1])
    clear_directory(roms_directory)

    for gameListing in moonlight_games:
        game_name = gameListing.strip().split('.')[1].strip()
        sanitized_game_name = sanitize(game_name)
        for resolution in StreamStrings:
            launch_script = create_script(f"{game_name}", StreamStrings[resolution])
            write_script(launch_script, resolution, sanitized_game_name, False)
except Exception as e:
    exit(e)
